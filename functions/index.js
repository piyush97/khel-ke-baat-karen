const functions = require("firebase-functions");
const cors = require("cors")({ origin: true });
const Busboy = require("busboy");
const os = require("os");
const path = require("path");
const fs = require("fs");
const fbAdmin = require("firebase-admin");
const uuid = require("uuid/v4");
// // Create and Deploy Your First Cloud Functions
// // https://firebase.google.com/docs/functions/write-firebase-functions
//
// exports.helloWorld = functions.https.onRequest((request, response) => {
//  response.send("Hello from Firebase!");
// });

const gcconfig = {
  projectId: "khel-ke-baat-karen",
  keyFilename: "khel-ke-baat-karen-firebase-adminsdk-v8f7r-fdbb0f1604.json"
};

const gcs = require("@google-cloud/storage")(gcconfig);

fbAdmin.initializeApp({
  credential: fbAdmin.credential.cert(
    require("./khel-ke-baat-karen-firebase-adminsdk-v8f7r-fdbb0f1604.json")
  )
});

exports.storeImage = functions.https.onRequest((req, res) => {
  return cors(req, res, () => {
    if (req.method !== "POST") {
      return res.status(500).json({ message: "Not Allowed." });
    }
    if (
      req.headers.authorization ||
      !req.headers.authorization.startsWith("Bearer ")
    ) {
      return res.status(401).json({ error: "Unauthorized." });
    }
    let idToken;
    let uploadData;
    let oldImagePath;
    idToken = req.headers.authorization.split("Bearer ")[1];

    const busboy = Busboy({ headers: req.headers });

    busboy.on("file", (fieldname, file, filename, encoding, mimetype) => {
      const filePath = path.join(os.tmpdir(), filename);
      uploadData = { filePath: filePath, type: mimetype, name: filename };
      file.pipe(fs.createWriteStream(filePath));
    });
    busboy.on("field", (fieldname, value) => {
      oldImagePath = decodeURIComponent(value);
    });
    busboy.on("finish", () => {
      const bucket = gcs.bucket("khel-ke-baat-karen.appspot.com");
      const id = uuid();
      let imagePath = "images/" + id + "-" + uploadData.name;
      if (oldImagePath) {
        imagePath = oldImagePath;
      }
      return fbAdmin
        .auth()
        .verifyIdToken(idToken)
        .token(decodedToken => {
          return bucket.upload(uploadData.filePath, {
            uploadType: "media",
            destination: imagePath,
            metadata: {
              metadata: {
                contentType: uploadData.type,
                firebaseStorageDownloadToken: id
              }
            }
          });
        })
        .then(() => {
          return res.status(201).jsoon({
            imageUrl:
              "https://firebasestorage.googleapis.com/v0/b/" +
              bucket.name +
              "/0/" +
              encodeURIComponent(imagePath) +
              "?alt=media&token=" +
              id
          });
        })
        .catch(error => {
          return res.status(401).json({ error: "Unauthorized" });
        });
    });
  });
});

const functions = require("firebase-functions");
const admin = require('firebase-admin');
const { UserBuilder } = require("firebase-functions/v1/auth");


admin.initializeApp()

const db = admin.firestore()

exports.changeLastMessage = functions.firestore
  .document('directs/{roomId}/messages/{messageId}')
  .onUpdate((change, context) => {
    const message = change.after.data()
    if (message) {
      return db.doc('directs/' + context.params.roomId).update({
        lastMessages: [message],
      })
    } else {
      return null
    }
  })

exports.changeMessageStatus = functions.firestore
  .document('directs/{roomId}/messages/{messageId}')
  .onWrite((change, context) => {
    const message = change.after.data()
    const authorId = message.authorId;
    var receivedId;
    var docRef = db.collection("directs").doc(context.params.roomId);

    docRef.get().then((doc) => {
        if (doc.exists) {
        console.log("Document data:", doc.data().userIds);

        doc.data().userIds.map(function(userId, i) {
            console.log('[forEach]', userId, i);
            if (userId != authorId) {
                receivedId = userId;
            }
        })
        console.log("Received id", receivedId);

        if(receivedId != null) {
            var userRef = db.collection("users").doc(receivedId);
            var userAuthor = db.collection("users").doc(authorId);
            var authorName = "";
            userAuthor.get().then((userAuth) => {
                authorName = userAuth.data().firstName;
             });

            userRef.get().then((user) => {
                if (user.exists) {
                    console.log("message :", message.text);
                    console.log("user:", authorName + " enviou uma mensagem..");
                    
                    var push = { 
                        app_id: "459e89fb-4c9f-451e-893b-4ebe85940400",
                        channel_for_external_user_ids: "push",
                        contents: {"en": message.text},
                        headings: {"en": authorName + " enviou uma mensagem.."},
                        include_external_user_ids: [user.data().metadata['token']]
                      };
                      
                      sendNotification(push);
                }
            });
        }

        } else {
        // doc.data() will be undefined in this case
        console.log("No such document!");
        }
    }).catch((error) => {
        console.log("Error getting document:", error);
    });
    
    
    if (message) {
      if (['delivered', 'seen', 'sent'].includes(message.status)) {
        return null
      } else {
        
        return change.after.ref.update({
          status: 'delivered',
        })
      }
    } else {
      return null
    }
  })

  var sendNotification = function(data) {
    var headers = {
      "Content-Type": "application/json",
      "Authorization": "Basic NWFkYTdkODUtYTlkOS00YTY0LThhMTQtNmQ1MmIxZjliNzdl"
    };
  
    var options = {
      host: "onesignal.com",
      port: 443,
      path: "/api/v1/notifications",
      method: "POST",
      headers: headers
    };
  
    var https = require('https');
    var req = https.request(options, function(res) {  
      res.on('data', function(data) {
        console.log("Response:");
        console.log(JSON.parse(data));
      });
    });
  
    req.on('error', function(e) {
      console.log("ERROR:");
      console.log(e);
    });
  
    req.write(JSON.stringify(data));
    req.end();
  };
  
  
firebase.initializeApp({
    'messagingSenderId': '15741502636'
  });
const messaging = firebase.messaging();
messaging.requestPermission()
.then(function() {
  console.log('Notification permission granted.');
  // TODO(developer): Retrieve an Instance ID token for use with FCM.
  // ...
})
.catch(function(err) {
  console.log('Unable to get permission to notify.', err);
});

messaging.getToken()
.then(function(currentToken) {
  if (currentToken) {
      console.log("Current token is", currentToken)
  } else {
    // Show permission request.
    console.log('No Instance ID token available. Request permission to generate one.');
    // Show permission UI.
    updateUIForPushPermissionRequired();
    setTokenSentToServer(false);
  }
})
.catch(function(err) {
});

messaging.onMessage(function(payload) {
    console.log("Message received. ", payload);
});
String getFirebaseErrorString(String code) {
  switch (code) {
    case "user-not-found":
      return "This email is not registered";
    case "wrong-password":
      return "The password is wrong";
    case "email-already-in-use":
      return "This email is already registered";
    default:
      return "Something went wrong";
  }
}

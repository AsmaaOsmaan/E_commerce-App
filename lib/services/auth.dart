import'package:firebase_auth/firebase_auth.dart';

class Auth{
final auth=FirebaseAuth.instance;
Future<AuthResult>SignUp(String email,String password)async{
  final authResult= await auth.createUserWithEmailAndPassword(email: email, password: password);
  return authResult;
}


Future<AuthResult>SignIn(String email,String password)async{
  final authResult= await auth.signInWithEmailAndPassword(email: email, password: password);
  return authResult;
}
Future<void>SignOut()async{
  await auth.signOut();
}
}

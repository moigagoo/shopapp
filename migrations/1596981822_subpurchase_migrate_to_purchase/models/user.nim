import norm/model


type
  User* = ref object of Model
    email*: string
    googleToken*: string


func newUser*(email, googleToken: string): User =
  User(email: email, googleToken: googleToken)

func newUser*: User =
  newUser("", "")

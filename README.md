# SWStatesHUD

A simple indicator of loading, success and failure.

Usage is similar to Alert API, for example:
```
VStack {
    // Some View
}
.states(item: $statesHUDItem)
.alert(item: $alertItem) { (item) -> Alert in
    Alert(title: item.title, message: item.message)
}
```

You can set the number of seconds to close the HUD:
```
statesHUDItem = SWStatesHUDItem(type: .success, message: "Login Succeeded", dismissAfter: 1)
```

and completion:
```
SWStatesHUDItem(type: .success, message: "Login Succeeded", dismissAfter: 1) {
    print("Already login")
}

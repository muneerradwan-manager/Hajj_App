## /api/Auth/forgot-password

# request:

```json
{
  "email": "user@example.com"
}
```

# response/200

```json
{
  "message": "If the email exists, an OTP has been sent."
}
```

# request:

```json
{
  "email": "muneer.radwan.manager@gmail.com"
}
```

# response/200

```json
{
  "message": "OTP sent to email."
}
```

## /api/Auth/reset-password

# request:

```json
{
  "email": "user@example.com",
  "otp": "string",
  "newPassword": "string",
  "confirmPassword": "string"
}
```

# response/400

```json
{
  "message": "Invalid email or OTP."
}
```

## /api/Auth/reset-password

# request:

```json
{
  "email": "user@example.com",
  "otp": "string",
  "newPassword": "string",
  "confirmPassword": "string"
}
```

# response/400

```json
{
  "message": "Invalid email or OTP."
}
```

# request:

```json
{
  "email": "muneer.radwan.manager@gmail.com",
  "otp": "4727",
  "newPassword": "string",
  "confirmPassword": "string"
}
```

# response/400

```json
{
  "errors": [
    "Passwords must have at least one non alphanumeric character.",
    "Passwords must have at least one digit ('0'-'9').",
    "Passwords must have at least one uppercase ('A'-'Z')."
  ]
}
```

# request:

```json
{
  "email": "muneer.radwan.manager@gmail.com",
  "otp": "4727",
  "newPassword": "Password!123",
  "confirmPassword": "Password!123"
}
```

# response/200

```json
{
  "message": "Password reset successful."
}
```

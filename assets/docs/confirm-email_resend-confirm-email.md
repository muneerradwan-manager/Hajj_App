## /api/Auth/confirm-email

# request:

```json
{
  "email": "muneer.radwan.manager@gmail.com",
  "otp": "3961"
}
```

# response/200

```json
{
  "message": "Email confirmed successfully."
}
```

# request:

```json
{
  "email": "muneer.radwan.manager@gmail.com",
  "otp": "4574"
}
```

<!-- 204 No Content -->
# response/200

```json
{
  "message": "Email already confirmed."
}
```

# request (after a while):

```json
{
  "email": "muneer.radwan.manager@gmail.com",
  "otp": "4574"
}
```

<!-- 204 No Content -->
# response/400

```json
{
  "message": "Email already confirmed."
}

# request:

```json
{
  "email": "muneer.radwan.sdfsdf@gmail.com",
  "otp": "4574"
}
```

<!-- 404 Not Found -->

# response/400

```json
{
  "message": "Invalid email or OTP."
}
```

## /api/Auth/resend-confirm-email

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

<!-- 204 No Content -->

# response/400

```json
{
  "message": "Email is already confirmed."
}
```

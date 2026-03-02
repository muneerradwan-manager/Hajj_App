## /api/Auth/register

# request:

```json
{
  "email": "muneer.radwan.manager@gmail.com",
  "phone": "sdvsdv",
  "nationalityNumber": "02350030725",
  "barcode": 1500003,
  "password": "password",
  "confirmPassword": "password"
}
```

# response/400 ->

```json
{
  "type": "https://tools.ietf.org/html/rfc9110#section-15.5.1",
  "title": "One or more validation errors occurred.",
  "status": 400,
  "errors": {
    "Phone": ["The Phone field is not a valid phone number."]
  },
  "traceId": "00-25cd4da7253dbe5c248c57d9cf340e0b-c3ba524143acba9e-00"
}
```

# request:

```json
{
  "email": "muneer.radwan.manager@gmail.com",
  "phone": "0947446326",
  "nationalityNumber": "02350030725",
  "barcode": 1500003,
  "password": "password",
  "confirmPassword": "password"
}
```

# response/409 ->

```json
{
  "message": "An account already exists for this pilgrim."
}
```

# request:

```json
{
  "email": "muneer.radwan.manager@gmail.com",
  "phone": "0947446326",
  "nationalityNumber": "02350030725",
  "barcode": 1500003,
  "password": "password",
  "confirmPassword": "password"
}
```

# request

```json
{
  "email": "muneer.radwan.manager@gmail.com",
  "phone": "0947446326",
  "nationalityNumber": "07090170380",
  "barcode": 1500004,
  "password": "password",
  "confirmPassword": "password"
}
```

# response/400 ->

```json
{
  "errors": [
    "Passwords must have at least one non alphanumeric character.",
    "Passwords must have at least one digit ('0'-'9').",
    "Passwords must have at least one uppercase ('A'-'Z')."
  ]
}
```

# request

```json
{
  "email": "muneer.radwan.manager@gmail.com",
  "phone": "0947446326",
  "nationalityNumber": "07090170380",
  "barcode": 1500004,
  "password": "Password!123",
  "confirmPassword": "Password!123"
}
```

# response/200 ->

```json
{
  "message": "Registration successful. OTP sent to email."
}
```

# request

```json
{
  "email": "muneergjghjghj@gmail.com",
  "phone": "0947446326",
  "nationalityNumber": "07090170380",
  "barcode": 345345,
  "password": "Password!123",
  "confirmPassword": "Password!123"
}
```

# response/400 ->

```json
{
  "message": "Pilgrim not found for provided barcode and nationality number."
}
```

## /api/Auth/login

# request:

```json
{
  "email": "user@example.com",
  "password": "string"
}
```

# response/401

```json
{
  "message": "Invalid credentials."
}
```

# request:

```json
{
  "email": "muneer.radwan.manager@gmail.com",
  "password": "Password!123"
}
```

# response/200

```json
{
  "token": "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiJmYTQzZWMzNC1lNmQzLTRiM2YtOTc5YS1lOTg4NmE0YTQ0NmEiLCJlbWFpbCI6Im11bmVlci5yYWR3YW4ubWFuYWdlckBnbWFpbC5jb20iLCJodHRwOi8vc2NoZW1hcy54bWxzb2FwLm9yZy93cy8yMDA1LzA1L2lkZW50aXR5L2NsYWltcy9uYW1laWRlbnRpZmllciI6ImZhNDNlYzM0LWU2ZDMtNGIzZi05NzlhLWU5ODg2YTRhNDQ2YSIsImh0dHA6Ly9zY2hlbWFzLnhtbHNvYXAub3JnL3dzLzIwMDUvMDUvaWRlbnRpdHkvY2xhaW1zL21vYmlsZXBob25lIjoiMDk0NzQ0NjMyNiIsImJhcmNvZGUiOiIxNTAwMDA0IiwicGlsZ3JpbUlkIjoiMiIsImV4cCI6MTc3MjQ0MTA5MCwiaXNzIjoiTW9iaWxlQXBwQVBJIiwiYXVkIjoiTW9iaWxlQXBwQVBJIn0.ZTySBgw77f2Tga346Mtx_LHlPi5Sp19rO5VPvcmMQ0g",
  "expiresAt": "2026-03-02T08:44:50.0137227Z",
  "refreshToken": "7SvrGYrqyQsbFWAnY58qCrpLEzmiaXjofU64bnSMSToXB/2d8fam+ynMpONLNyFcNRkW4L07PMBPSUOMjU3MgA==",
  "refreshTokenExpiresAt": "2026-03-09T07:44:50.0531477Z"
}
```

<!-- if i am using old token its still status code= 200 with this message: Logged out. Client should discard the token. -->

## /api/Auth/logout

# request:

<!-- Bearer Token Authorization. -->

# response/401

```json
{
  "message": "Logged out. Client should discard the token."
}
```

## /api/Auth/refresh-token

# request:

```json
{
  "refreshToken": "FVTQQXxgBInQ+cgs9+K06NmsGqiIijRCI4L+PKvI8pXZ9YfsCcSsM/hZ12aBOdyQKdI+U9Pzmf4s3yudhMzHTg=="
}
```

# response/400

```json
{
  "token": "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiJmYTQzZWMzNC1lNmQzLTRiM2YtOTc5YS1lOTg4NmE0YTQ0NmEiLCJlbWFpbCI6Im11bmVlci5yYWR3YW4ubWFuYWdlckBnbWFpbC5jb20iLCJodHRwOi8vc2NoZW1hcy54bWxzb2FwLm9yZy93cy8yMDA1LzA1L2lkZW50aXR5L2NsYWltcy9uYW1laWRlbnRpZmllciI6ImZhNDNlYzM0LWU2ZDMtNGIzZi05NzlhLWU5ODg2YTRhNDQ2YSIsImh0dHA6Ly9zY2hlbWFzLnhtbHNvYXAub3JnL3dzLzIwMDUvMDUvaWRlbnRpdHkvY2xhaW1zL21vYmlsZXBob25lIjoiMDk0NzQ0NjMyNiIsImJhcmNvZGUiOiIxNTAwMDA0IiwicGlsZ3JpbUlkIjoiMiIsImV4cCI6MTc3MjQ0MjE1NywiaXNzIjoiTW9iaWxlQXBwQVBJIiwiYXVkIjoiTW9iaWxlQXBwQVBJIn0.kXIvWHwQ2XeaXoOmDNX35A9_3ug-w0u61sYjwKvMxzU",
  "expiresAt": "2026-03-02T09:02:37.1321098Z",
  "refreshToken": "+vr1bmcfaaOdHGj8va8KRqTkM5N6ML480whe5MLvLsgBzLW6rikjPQjmFexdB0cLMkzHojLjgaOfSBMoD9fVfg==",
  "refreshTokenExpiresAt": "2026-03-09T08:02:37.1321439Z"
}
```

# request:

```json
{
  "refreshToken": "string"
}
```

# response/400

```json
{
  "message": "Invalid or expired refresh token."
}
```

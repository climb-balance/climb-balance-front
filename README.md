# 클라임 밸런스[프론트]

# 초기 설정(안드로이드)

## 1. 네이버

`/android/app/src/main/res/values`에 `naver.xml`을 만들어

```xml
<?xml version="1.0" encoding="utf-8"?>
<resources>
    <string name="client_id">클라아이디</string>
    <string name="client_secret">클라시크릿</string>
    <string name="client_name">클라임밸런스</string>
</resources>
```

을 채워준다.

## 2. package pull

```
flutter pub get 
```

## 3. generate code

```
flutter pub run build_runner build --delete-conflicting-outputs
```

## 끝
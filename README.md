# README
### Post example curl

```
curl -i -X POST http://localhost:3000/images \
        -H "Content-Type: image/jpeg" \
        --data-binary "@/Users/ema/Desktop/example.jpg"

curl -i -X POST http://localhost:3000/images \
        -H "Content-Type: image/jpeg" \
        -T "/Users/ema/Desktop/example.jpg"
```
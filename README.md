# deepface-api

## build and run
```
docker build -t deepface .
docker run -dp 5000:5000 --gpus all deepface 
```




## api usage
### /deepface
result sample
```
[
    {
        "age": 39,
        "gender": "Man",
        "race": "white",
        "region": [
            172,
            131,
            457,
            516
        ]
    }
]
```


curl
```
curl --location --request POST 'http://127.0.0.1:5000/deepface' \
--form 'image=@"/Users/ghoul/Downloads/Clayton%20Irwin.jpeg"'
```

python
```
def download_image(url):
    rep = requests.get(url)
    return rep.content

def detect(content):
    response = requests.post('http://127.0.0.1:5000/deepface', files={'image': BytesIO(content)})
    return response.json()

if __name__ == '__main__':
    print(detect(download_image("https://lnkd-photo.s3-us-west-2.amazonaws.com/ACoAAA-8f78BXAkawQoGchpxY4o1Ri4gvIEgOWA")))
```

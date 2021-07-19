# GiphySearch

<img src="https://user-images.githubusercontent.com/76767233/126121997-86d9667a-cda7-49ff-b56e-8525d5328226.gif">

입력한 검색어로 Giphy API를 이용해 GIF를 검색하는 side project 앱

## Purpose 
collcetionView의 Custom Layout 구현

paging(무한스크롤) 구현

image caching 구현


## Getting Started
Giphy의 Search API를 사용하기 위해 API KEY 발급이 필요합니다.

https://developers.giphy.com/docs/api <- 이곳에서 발급 받은 후 constants.swift 파일 내 변수에 할당해주면 됩니다.
```
// constants.swift 
let API_KEY = "YOUR_API_KEY"
```

### Installing

아래와 같은 라이브러리를 사용하였습니다.

Alamofire

Kingfisher

만약 프로젝트에서 해당 라이브러리를 찾지 못해 빌드가 되지 않으면 콘솔창에서 프로젝트 폴더로 이동 후
```
pod install
```
커맨드를 실행해 주면 됩니다.

## Spec
Target : ver 12.1

Swift 5


# Tech News (Demo)

A demonstration of fetching news from the HN Search API and displaying it on the screen using SwiftUI
## Demo

![GIF](giflink)
## Highlights

1. Set up a JSON decoding structure
```
struct Root: Decodable {
    let hits: [HitpostData]
}

struct HitpostData: Decodable, Identifiable {
    
    var id: String {
        return objectID
    }
    let num_comments: Int
    let objectID: String
    let points: Int
    let title: String
    let url: String?
}
```

2. I needed to fetch the data from the API
(https://hn.algolia.com/api)

class NetworkManager is observed, and the hitposts property is wrapped with @Published.

```
class NetworkManager: ObservableObject {
    


    @Published var hitposts = [HitpostData]()
}
```


```
func fetch() {
        if let url = URL(string: "https://hn.algolia.com/api/v1/search?tags=front_page") {
            let session = URLSession(configuration: .default)
            let task = session.dataTask(with: url) { (data, response, error) in
                if error == nil {
                    
                    let decoder = JSONDecoder()
                    
                    if let safeData = data {
                        do {
                            let results = try decoder.decode(Root.self, from: safeData)
                            
                            DispatchQueue.main.async {
                                self.hitposts = results.hits
                            }
                        } catch {
                            
                            print (error)
                            
                        }
                    }
                }
            }
            task.resume()
```


3. Web View and Detail View
  
 
 
 
WebView,

```
struct WebView: UIViewRepresentable {
    
    let url: String?

    func makeUIView(context: Context) -> WKWebView {
        return WKWebView()
    }

    func updateUIView(_ uiView: WKWebView, context: Context) {
        
        if let safeURL = url {
            if let url = URL(string: safeURL) {
                let request = URLRequest(url: url)
                uiView.load(request)
            }
        }
    }
}
```
 
  

DetailView,
```
struct DetailView: View {
    let url: String?
    
    var body: some View {
        WebView(url: url)
            .ignoresSafeArea(.all)
    }
}
```

Now, combine all of the above and display it on the main ContentView.

```
struct ContentView: View {
    
    @ObservedObject var networkManager = NetworkManager() // Subscribing to observable NetworkManager
    
    var body: some View {
        
        NavigationView {
            List(networkManager.hitposts) { post in
                NavigationLink(destination: DetailView(url: post.url)) {
                    
                    HStack{
                        Text("\(post.num_comments)")
                        Text(post.title)
                    }
                }
                
            }
            
            .navigationBarTitle ("Tech News")
        }
        .onAppear {
            networkManager.fetch()
        }
        
    }
}
```
 

 

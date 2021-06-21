CGO_ENABLED=0 GOOS=windows GOARCH=amd64 go build -ldflags '-X main.version=v0.1.0 -X main.commit=f64dbdd -X main.date=2021-06-22' -o assets/exec-v0.1.0-windows-x86_64.exe main.go

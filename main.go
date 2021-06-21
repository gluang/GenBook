package main

import (
	"context"
	"fmt"
	"log"
	"net/http"
	"os"
	"os/signal"
	"time"

	"github.com/gluang/GenBook/docs"
)

var (
	version string
	commit  string
	date    string
)

func main() {

	args := os.Args
	if len(args) == 2 && (args[1] == "--version" || args[1] == "-v") {
		fmt.Printf("Release version : %s\n", version)
		fmt.Printf("Git commit      : %s\n", commit)
		fmt.Println("Author          : gluang")
		fmt.Printf("Build date      : %s\n", date)
		return
	}

	var port string = "8800"
	if len(args) == 3 && (args[1] == "--port" || args[1] == "-p") {
		port = args[2]
	}

	fileServer := http.FileServer(http.FS(docs.StaticFs))
	var srv = &http.Server{
		Addr:    ":" + port,
		Handler: fileServer,
	}

	go func() {
		log.Println("Serving on http://localhost:" + port)
		err := srv.ListenAndServe()
		if err != nil && err != http.ErrServerClosed {
			log.Fatalf("Listen:%s\n", err)
		}
	}()

	listenSignal(srv)

}

func listenSignal(srv *http.Server) {

	ctx, stop := signal.NotifyContext(context.Background(), os.Interrupt)
	<-ctx.Done()

	stop()

	timeoutCtx, cancel := context.WithTimeout(context.Background(), 5*time.Second)
	defer cancel()

	if err := srv.Shutdown(timeoutCtx); err != nil {
		log.Fatalf("Shutdown:%s\n", err)
	}
	fmt.Println()
	log.Println("✔️ close service successfully")
}

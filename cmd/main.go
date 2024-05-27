package main

import (
	"context"
	"github.com/amzdll/shop_auth/internal/app"
)

func main() {
	ctx := context.Background()
	application := app.CreateApp()
	err := application.Start(ctx)
	if err != nil {
		return
	}
}

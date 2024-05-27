package api

import (
	"context"
	"github.com/amzdll/shop_auth/internal/app/logger"
	"github.com/amzdll/shop_auth/internal/config"
	"github.com/go-chi/chi/v5"
	"go.uber.org/fx"
	"net"
	"net/http"
)

func Module() fx.Option {
	return fx.Module(
		"api",
		fx.Options(
			authModule(),
			accessModule(),
		),
		fx.Provide(fx.Annotate(setupMainRouter, fx.ParamTags(`group:"routes"`))),
		fx.Provide(config.NewApiConfig),
		fx.Invoke(runServer),
	)
}

func runServer(lc fx.Lifecycle, router *chi.Mux, config *config.ApiConfig, l *logger.Logger) {
	lc.Append(fx.Hook{
		OnStart: func(context.Context) error {
			listener, err := net.Listen("tcp", config.Port)
			if err != nil {
				l.Error("Cannot start server", err)
				return err
			}
			l.Info("Server has started successfully.")
			if err = http.Serve(listener, router); err != nil {
				l.Error("Cannot start server", err)
				return err
			}
			l.Info("Server has started successfully.")
			return nil
		},
		OnStop: func(context context.Context) error {
			return nil
		},
	})
}

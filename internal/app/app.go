package app

import (
	"github.com/amzdll/shop_auth/internal/app/api"
	"github.com/amzdll/shop_auth/internal/app/db"
	"github.com/amzdll/shop_auth/internal/app/logger"
	"github.com/amzdll/shop_auth/internal/config"
	"go.uber.org/fx"
)

func CreateApp() *fx.App {
	return fx.New(
		fx.Options(
			logger.Module(),
			db.Module(),
			api.Module(),
		),
		fx.Provide(config.NewConfig),
		fx.NopLogger,
	)
}

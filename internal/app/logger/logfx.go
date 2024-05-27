package logger

import (
	"github.com/amzdll/shop_auth/internal/config"
	"go.uber.org/fx"
)

func Module() fx.Option {
	return fx.Module(
		"Logger",
		fx.Provide(NewLogger),
		fx.Provide(config.NewLoggerConfig),
	)
}

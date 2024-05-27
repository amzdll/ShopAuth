package db

import "go.uber.org/fx"

func Module() fx.Option {
	return fx.Module(
		"DB",
		fx.Options(pgModule()),
	)
}

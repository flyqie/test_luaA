pg = pg or {}
pg.Live2DMgr = singletonClass("Live2DMgr")
this = pg.Live2DMgr

function this.Ctor(arg_1_0)
	arg_1_0.loader = AutoLoader.New()
end

function this.GetLive2DModelAsync(arg_2_0, arg_2_1, arg_2_2)
	return (arg_2_0.loader:LoadLive2D(arg_2_1, arg_2_2))
end

function this.StopLoadingLive2d(arg_3_0, arg_3_1)
	arg_3_0.loader:ClearRequest(arg_3_1)
end

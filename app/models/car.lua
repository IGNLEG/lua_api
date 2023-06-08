local Car = dofile("app/models/model.lua")

Car.set_table_name("cars") --specify which DB table model should use

return Car
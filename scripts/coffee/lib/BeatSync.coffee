module.exports = class BeatSync

	constructor: (@passTime, @countToPass, @tolerance) ->

		@_events = {}

		@time = 0
		@counter = 0

	tap: ->

		if @time isnt 0

			now = Date.now()

			diff = now - @time

			if Math.abs(diff - @passTime) < @tolerance

				if ++@counter >= @countToPass

					@_events.finish() if @_events.finish?

					do @reset

				else

					@_events.hit(@counter) if @_events.hit?

					@time = now

			else

				@_events.miss() if @_events.miss?

				do @reset

		else

			@_events.start() if @_events.start?

			@time = Date.now()

	reset: ->

		@time = 0

		@counter = 0

	on: (job, callback) ->

		@_events[job] = callback
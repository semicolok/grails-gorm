package sampleboard

import grails.converters.JSON

class BoardController {
	
//	static allowedMethods = [save: "POST", update: "POST", delete: "POST"]
	
	def boardService
	
	def index = {}
	
	def board = {
		switch(request.method){
			case 'GET' :
				if (params.id){
					def result = [board: boardService.findById(params.id)]
					render result as JSON
				} else {
					//동일한 기능의 코드
					def result = [boardList: boardService.getAll()]
					render result as JSON
				//		render(view: 'index', model: [boardList: boardService.getAll()])
				}
				break
			case 'PUT' :
				def board = new Board(params)
				def result
				if(params.id){
					result = [result: boardService.update(board, params.id)]
				} else {
					result = [result: boardService.save(board)]
				}
				render result as JSON
				break
			
			case 'DELETE' :
				def result = [result: boardService.remove(params.id)]
				render result as JSON
				break
		}
	}
}

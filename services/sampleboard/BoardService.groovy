package sampleboard

class BoardService {

	def getAll() {
		Board.list()
	}
	
	def findById(def id) {
		Board.get(id)
	}

	Boolean save(Board board){
		if (board.save()){
			true
		} else {
			false
		}
	}
	
	Boolean update(Board board, def id){
		def targetBoard = Board.get(id)
		if (targetBoard !=  null){
			targetBoard.title = board.title
			targetBoard.writer = board.writer
			targetBoard.content = board.content
			targetBoard.lastUpdate =  new Date()
			if (targetBoard.save()){
				true
			} else {
				false
			}
		}
		false
	}
	
	Boolean remove(def id){
		if(id){
			def board = Board.get(id)
			if(board){
				board.delete()
				true
			}
		} else {
			false
		}
	}
}

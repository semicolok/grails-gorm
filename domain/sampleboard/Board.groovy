package sampleboard

class Board {
	Long id
	String title
	String writer
	String content
	Date createdDate = new Date()
	Date lastUpdate  = new Date()

    static constraints = {
		id unique: true
		title blank: false, nullable: false
		writer blank: false, nullable: false
		content blank: false, nullable: false
		createdDate blank: true, nullable: true
		lastUpdate blank: true, nullable: true
    }
}

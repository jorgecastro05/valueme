package valueme

class Param {

	String id
	String name
	String value
	String description
	String label

    static constraints = {
    	name index: true
    	name unique: true
			value nullable: true
			label nullable: true
    }
}

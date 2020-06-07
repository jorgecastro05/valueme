package valueme

class Param {

	String id
	String name
	String value 
	String description
	String label

    static constraints = {
    	name index: true, unique: true
		value nullable: true
		label nullable:true
    }

	static mapping = {
        value column: "value", sqlType: "varchar", length: 5000
    }
}

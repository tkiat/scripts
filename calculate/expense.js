function arr_sum(arr) {
	return arr.reduce((x, y) => x + y, 0)
}

var fs = require("fs")

var output = {}
var filename = process.argv[2]
fs.readFile(filename, (err, data) => {
	if (err) {
		return console.error(err)
	}
	let expense = JSON.parse(data)
	var total = 0
	var num_month = Object.values(expense)[0].length
	for(let type in expense) {
		sum = arr_sum(expense[type])
		output[type] = "sum: " + sum + ", avg: " + Math.round(sum/num_month)
		total += sum
	}
	output['total'] = "sum: " + total + ", avg: " + Math.round(total/num_month)
	console.table(output)
	fs.writeFile(filename + '-summary', JSON.stringify(output, null, 2), function(err) {
		if (err) {
			return console.error(err)
		}
	})
})

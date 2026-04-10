Extension { #name : 'Association' }

{ #category : '*Microdown-BookTester' }
Association >> isMicPaired [
	"
	7+3 >>> 10
	"
	
	^ self key = self value
]

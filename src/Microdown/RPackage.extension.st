Extension { #name : #RPackage }

{ #category : #'*Microdown' }
RPackage >> buildMicroDownUsing: aBuilder withComment: aString [
	
	self class environment at: self name 
		ifPresent: [ :cls | aBuilder 
			header:  [ :b | b text: self name ] withLevel: 1;
			text: 'A baseline is a kind of map to load project.';
			header: [:b | b text: 'Description'] withLevel: 3;
			text: aString; 
			header: [ :b | b text: 'Dependencies' ] withLevel: 3;
			codeblockTag: 'pharo' withBody:  (cls sourceCodeAt: #baseline: 
									ifAbsent: [ 'No baseline! Houston we have a problem' ]) ] 
		ifAbsent: [ aBuilder 
						header: [ :b | 
								b text: 'Package: '. 
								b text: self name] withLevel: 1;
						text: aString ]
	
]

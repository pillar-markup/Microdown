IceRepository registry 
	detect: [ :repo | 'Microdown' = repo name ]
	ifFound: [ :aRepository | aRepository forget ].
"This, however, needs to stay :)"

(RPackageOrganizer default packages
	select: [ :package | (package name includesSubstring: 'Microdown') or: [ package name includesSubstring: 'BeautifulComments'] ])
	do: [ :package | package removeFromSystem ].
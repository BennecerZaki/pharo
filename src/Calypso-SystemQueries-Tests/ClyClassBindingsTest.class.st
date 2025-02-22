Class {
	#name : #ClyClassBindingsTest,
	#superclass : #ClyQueryNavigationResultTest,
	#category : #'Calypso-SystemQueries-Tests-Results'
}

{ #category : #running }
ClyClassBindingsTest >> createQueryResult [
	^ClyClassBindingsResult new
]

{ #category : #tests }
ClyClassBindingsTest >> testFillingWithMetaclass [

	queryResult fillWith: {Array class}.
	
	self assert: queryResult items equals: {Array binding}.
	
]

{ #category : #tests }
ClyClassBindingsTest >> testFillingWithTwoClasses [

	queryResult fillWith: {Array. String}.
	
	self assert: queryResult items equals: {Array binding. String binding}.
	
]

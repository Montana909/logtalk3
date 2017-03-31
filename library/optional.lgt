%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%  
%  This file is part of Logtalk <http://logtalk.org/>  
%  Copyright 2017 Sergio Castro <sergioc78@gmail.com> and  
%  Paulo Moura <pmoura@logtalk.org>
%  
%  Licensed under the Apache License, Version 2.0 (the "License");
%  you may not use this file except in compliance with the License.
%  You may obtain a copy of the License at
%  
%      http://www.apache.org/licenses/LICENSE-2.0
%  
%  Unless required by applicable law or agreed to in writing, software
%  distributed under the License is distributed on an "AS IS" BASIS,
%  WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
%  See the License for the specific language governing permissions and
%  limitations under the License.
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


:- object(optional).

	:- info([
		version is 0.2,
		author is 'Sergio Castro and Paulo Moura',
		date is 2017/03/31,
		comment is 'Constructors for optional references. Optional references shoud be regarded as opaque terms and always used with the optional/1 object by passing the reference as a parameter.'
	]).

	:- public(empty/1).
	:- mode(empty(--nonvar), one).
	:- info(empty/1, [
		comment is 'Constructs an empty optional opaque reference.',
		argnames is ['Reference']
	]).

	:- public(of/2).
	:- mode(of(@object_identifier, --nonvar), one).
	:- info(of/2, [
		comment is 'Constructs an optional reference from an object identifier.',
		argnames is ['Object', 'Reference']
	]).

	empty(empty).

	of(Value, the(Value)).

:- end_object.


:- object(optional(_Reference)).

	:- info([
		version is 0.2,
		author is 'Sergio Castro and Paulo Moura',
		date is 2017/03/31,
		comment is 'Optional reference predicates.',
		parnames is ['Reference']
	]).

	:- public(is_empty/0).
	:- mode(is_empty, zero_or_one).
	:- info(is_empty/0, [
		comment is 'True if the optional is empty.'
	]).

	:- public(is_present/0).
	:- mode(is_present, zero_or_one).
	:- info(is_present/0, [
		comment is 'True if the optional is not empty.'
	]).

	:- public(if_present/1).
	:- meta_predicate(if_present(1)).
	:- mode(if_present(+callable), zero_or_more).
	:- info(if_present/1, [
		comment is 'Calls a lambda expression with the optional reference as parameter if not empty. Succeeds otherwise.',
		argnames is ['Lambda']
	]).

	:- public(map/2).
	:- meta_predicate(map(2, *)).
	:- mode(map(+callable, --nonvar), zero_or_more).
	:- info(map/2, [
		comment is 'Maps a lambda expression with the optional reference and a new reference as parameters.',
		argnames is ['Lambda', 'NewReference']
	]).

	:- public(get/1).
	:- mode(get(--object_identifier), one).
	:- info(get/1, [
		comment is 'Returns the optional encapsulated object identifier if not empty. Throws a resource error otherwise.',
		argnames is ['Object']
	]).

	is_empty :-
		parameter(1, empty).

	is_present :-
		parameter(1, the(_)).

	if_present(Lambda) :-
		parameter(1, Reference),
		(	Reference == empty ->
			true
		;	Reference = the(Object),
			call(Lambda, Object)
		).

	map(Lambda, NewReference) :-
		parameter(1, Reference),
		(	Reference = the(Object),
			call(Lambda, Object, NewObject) ->
			NewReference = the(NewObject)
		;	NewReference = empty
		).		

	get(Object) :-
		parameter(1, Reference),
		(	Reference == empty ->
			self(Self),
			sender(Sender),
			throw(error(resource_error, optional, logtalk(Self::get(Object), Sender)))
		;	Reference = the(Object)
		).

:- end_object.

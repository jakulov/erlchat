erl -sname boarderl -pa ebin -pa deps/cowboy/ebin -pa deps/ranch/ebin -pa deps/mimetypes/ebin -pa deps/gproc/ebin -boot start_sasl -s boarderl -sasl errlog_type error
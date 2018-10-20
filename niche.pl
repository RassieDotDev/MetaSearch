use strict;
use warnings;
use WWW::Mechanize;
use CGI;
my $q = CGI->new();

create_engine();


sub create_engine{
	print $q->header;
	print $q->start_html(-title => 'Niche Search Engine');
	print $q->start_form(
		-name    => 'main_form',
        -method  => 'GET',);
	print $q->textfield(
        -name      => 'search_query',
        -value     => 'Enter Search',
        -size      => 20,
        -maxlength => 30,
    );


	print $q->end_form;


}
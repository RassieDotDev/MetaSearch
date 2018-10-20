#!/usr/bin/perl -w

# time to code all three (including findind search engines to scrape):  1 hour 7 minutes

use strict;
use warnings;
use WWW::Mechanize;
use CGI;
my $q = CGI->new();
my $query_input = $q->param('query');
$query_input =~ s/ /+/g;
my $counter = 1;
my $link;
my @final_arr;
my $query="https://duckduckgo.com/html/?q=how-to-play-fetch";
my $query_bing="https://www.bing.com/search?q=how+to+play+fetch";
open(FILE, "+>", "links2.txt") or die "Unable to open file\n";
open (my $bing, "+>", "links3.txt") or die "Unable to open file\n";
my $m = WWW::Mechanize->new();
my $b = WWW::Mechanize->new();
$m->get($query);
$b->get($query_bing);

my @links = @{$m->links}; #STORES LINKS IN ARRAY
my @links_bing = @{$b ->links};
duck(<FILE>, @links);
bing($bing, @links_bing);


#foreach $link ( @links ) {
#	if($link->text cmp "Ad"){
#		shift @links;
#	}
    
#}
sub duck{
	my @array;

	#FIXING THE LINKS BY REMOVING NEWLINE CHARS AND DELMITING IT BY #
	#DUMPS INTO LINKS2.TXT
	foreach my $link ( @links ) {
		@array = split("\n", $link->text);
		foreach my $e (@array){
			printf FILE "%s#", $e;
		}

	}

	#RETURN TO TOP OF THE FrILE AND SPLIT IT INTO AN ARRAY AGAIN
	seek FILE , 0, 0;
	
	foreach my $lyn (<FILE>){
		@final_arr = split("#", $lyn);
	}

}

sub bing{
	my @array;

		#FIXING THE LINKS BY REMOVING NEWLINE CHARS AND DELMITING IT BY #
		#DUMPS INTO LINKS2.TXT
		foreach my $link ( @links ) {
			@array = split("\n", $link->text);
			foreach my $e (@array){
				printf $bing "%s#", $e;
			}

		}

		#RETURN TO TOP OF THE FrILE AND SPLIT IT INTO AN ARRAY AGAIN
		seek $bing , 0, 0;
		my @final_arr1;
		foreach my $lyn (<$bing>){
			@final_arr1 = split("#", $lyn);
		}

}

# print `wget $query -O duckduckgo-search.html`;

#undef $/;

#JUST TESTING OUT THE DIFFERENT COMMANDS
#my $find_urls1 = `lynx -dump -listonly $query | grep -o "https:.*"||"http:.*" |grep -E -v $query | uniq > links.txt`;

#my $find_urls = `lynx -dump -listonly $query`;
#my $find_urls2 = `lynx -dump $query> file2.txt`;


#$find_urls =~ s/[\w\W]+Visible links//mis;
#$find_urls=~s/(\\[(\\d+)\\])//;
#my @urllist;
#while( $find_urls =~ s/\s*(http[^\s]+)\s*// ){
#    $urllist[$#urllist+1] = $1;
#}

#my @nurllist;
#foreach my $url (@urllist){
#    next if $url =~ /duckduckgo/;
#    next if $url =~ /localhost/;
#    $nurllist[$#nurllist+1] = $url;
#}

##foreach my $url (@nurllist){
##    print $url, "\n";
##}


#WRITE TO HTML FILE

my $var;
my $t;
my $desc;
my$l;
my $file = "search.html";
local $/;
open my $fh, '+>>', $file or die "can't open $file: $!";
open my $f, '+>', "newlinks.txt" or die "can't open newlines";

truncate "search.html", 0;
foreach my $elem (@final_arr){
	print("$elem\n");
	if($counter ==1){
		$t = $elem;
		$counter++;
	}
	elsif($counter == 2){
		$desc = $elem;
		$counter++;
	}
	else{
		$l = $elem;
		
	    $var = <$fh>;
	    if($t eq "Ad" || $desc eq "Ad" ){
	    	$counter = 1;
	    	shift @final_arr;
	    }		
	    else{
	    	print $f ("$t\n$desc\n$l\n");
	    	print $fh ("<div ><a href=$l target=_blank>$t</a><p style=width:40%>$desc</p><br></br></div>");
	  		$counter = 1;
	    }
	  
	}
	
}



	
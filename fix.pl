#!/usr/bin/perl
use strict;
use warnings;

#sub to delete a specific character from a string
# by skipping the first n and deleting the rest
# deletechar( ref to string, first n to skip, char to delete )
# n
sub deletechar {
	my $stringref = shift @_;
	my $skip = shift @_;
	my $char = shift @_;

	# start position for index function
	# at the begining
	my $pos = 0;

	# count of the no of matches found
	my $count = 0;

	# search for next char until not found
	while ((my $index = index($$stringref, $char, $pos)) != -1) {
		# count the number of matches
		$count++;
		#print "count = $count index = $index\n";

		# delete ; for count > skip
		if ($count > $skip) {
			# delete special character after skiping skip chars
			my $found = substr($$stringref,$index,1, "");
			#print "count = $count found = $found $$stringref\n";
			# next position to search from does not change
			# as ; was deleted
			$pos = $index;
		} else {
			# move offset for index by 1 since
			# we do not want to find the same one again
			# this is for no change to string
			$pos = $index + 1;
		}
	}
}
# read ~./git-credentials into memory
my $gcfile = "/home/robert/test.txt";
#output file
my $newfile = "/home/robert/new.txt";
# no of special chars to skip
my $skip = 2;
# special char
my $spechar = ":";

# open file for reading
open(GC, "<", $gcfile) or die "could not open $gcfile $!\n";

# read file
my @file = <GC>;
chomp(@file);

# close file
close GC;

# foreach line
# look for the line that starts with https
# delete all special chars in this line
# write lines to new file
open NF, ">", $newfile or die "could not open newfile: $!\n";

foreach my $line (@file) {
	# if line starts with https then edit it
	# and remove special characters
	if ($line =~ /^https/) {
		# delete all the special chars
		deletechar(\$line, $skip, $spechar);
	}

	# write lines to file
	print NF "$line\n";
}
close NF;

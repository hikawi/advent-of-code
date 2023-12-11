use strict;
use warnings;

use Path::Tiny;
use List::Util qw(all);

my @contents = split(/\n/, path("./input.txt")->slurp_utf8());

sub get_empty_rows {
    my @contents = @_;
    my @empty_rows = ();

    for my $idx (0 .. $#contents) {
        if (all { $_ eq "." } split(//, $contents[$idx])) {
            push @empty_rows, $idx;
        }
    }

    return \@empty_rows;
}

sub get_empty_cols {
    my @contents = @_;
    my @empty_cols = ();

    for my $x (0 .. length($contents[0]) - 1) {
        my $col = "";
        for my $y (0 .. $#contents) {
            $col .= substr($contents[$y], $x, 1);
        }

        if (all { $_ eq "." } split(//, $col)) {
            push @empty_cols, $x;
        }
    }

    return \@empty_cols;
}

sub look_for_galaxies {
    my @contents = @_;
    my @galaxies = ();

    for my $y (0 .. $#contents) {
        my $line = $contents[$y];
        for my $x (0 .. length($line) - 1) {
            if (substr($line, $x, 1) eq "#") {
                push @galaxies, [$x, $y];
            }
        }
    }

    return \@galaxies;
}

sub distance_between {
    my ($first, $second) = @_;
    my ($a_x, $a_y) = @$first;
    my ($b_x, $b_y) = @$second;
    return abs($a_x - $b_x) + abs($a_y - $b_y);
}

sub expand {
    my ($contents_ref, $how_much) = @_;
    my @contents = @$contents_ref;

    my $old_galaxies = look_for_galaxies(@contents); # Make two copy.
    my $new_galaxies = look_for_galaxies(@contents); # We're modifying this.

    my $empty_rows = get_empty_rows(@contents);
    my $empty_cols = get_empty_cols(@contents);

    # Expand vertically. We check for old galaxies ones to not
    # be affected by the constant expansion.
    for my $row (@$empty_rows) {
        for my $idx (0 .. scalar @$old_galaxies - 1) {
            if ($old_galaxies->[$idx]->[1] > $row) {
                $new_galaxies->[$idx]->[1] += $how_much;
            }
        }
    }

    # Expand horizontally. We check for old galaxies ones to not
    # be affected by the constant expansion.
    for my $col (@$empty_cols) {
        for my $idx (0 .. scalar @$old_galaxies - 1) {
            if ($old_galaxies->[$idx]->[0] > $col) {
                $new_galaxies->[$idx]->[0] += $how_much;
            }
        }
    }

    return $new_galaxies;
}

sub dist_sum {
    my ($how_much) = @_;
    my $galaxies_ref = expand(\@contents, $how_much);
    my @galaxies = @$galaxies_ref;
    my $dist_sum = 0;

    for my $i (0 .. $#galaxies - 1) {
        for my $j ($i .. $#galaxies) {
            $dist_sum += distance_between($galaxies[$i], $galaxies[$j]);
        }
    }

    return $dist_sum;
}

sub solve_part_one {
    print dist_sum(1) . "\n";
}

sub solve_part_two {
    print dist_sum(999999) . "\n";
}

solve_part_one();
solve_part_two();

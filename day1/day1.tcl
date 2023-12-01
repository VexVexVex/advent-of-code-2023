proc swap_numbers {a} {
    regsub -all {one} $a o1e a
    regsub -all {two} $a t2o a
    regsub -all {three} $a t3e a
    regsub -all {four} $a 4 a
    regsub -all {five} $a 5e a
    regsub -all {six} $a 6 a
    regsub -all {seven} $a 7n a
    regsub -all {eight} $a e8t a
    regsub -all {nine} $a n9e a
    return $a
}

set total 0
set f [open input.txt r]
set lines [split [read $f] "\n"]
close $f
foreach line $lines {
    set number_list {}
    set line [swap_numbers $line]
    foreach char [split $line ""] {
        if {[string is integer -strict $char]} {
            lappend number_list $char
        }
    }
    set first [lindex $number_list 0]
    set last [lindex $number_list end]
    set total [expr $total + ($first * 10)]
    set total [expr $total + $last]
    puts $total
}

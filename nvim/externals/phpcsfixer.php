<?php

$finder = (new PhpCsFixer\Finder())
    ->in(__DIR__)
;

return (new PhpCsFixer\Config())
    ->setRules([
        '@PSR12' => true,
        'control_structure_continuation_position' => ['position' => 'next_line'],
        'braces_position' => ['functions_opening_brace' => 'same_line'],
    ])
    ->setFinder($finder)
;

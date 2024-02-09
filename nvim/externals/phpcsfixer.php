<?php

$finder = (new PhpCsFixer\Finder())
    ->in(__DIR__)
;

return (new PhpCsFixer\Config())
    ->setRules([
        '@PSR12' => true,
        'control_structure_continuation_position' => ['position' => 'next_line'],
    ])
    ->setFinder($finder)
;

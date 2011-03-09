<?php

function smarty_modifier_difference($string)
{
  return (doubleval($string) > 0.0 ? "+" : "") .$string;
}

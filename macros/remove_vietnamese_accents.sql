{% macro remove_vietnamese_accents(column_name) -%}
{%- set replacements = {
    "A": "[ÁÀẢÃẠĂẮẰẲẴẶÂẤẦẨẪẬ]",
    "a": "[áàảãạăắằẳẵặâấầẩẫậ]",
    "E": "[ÉÈẺẼẸÊẾỀỂỄỆ]",
    "e": "[éèẻẽẹêếềểễệ]",
    "I": "[ÍÌỈĨỊ]",
    "i": "[íìỉĩị]",
    "O": "[ÓÒỎÕỌÔỐỒỔỖỘƠỚỜỞỠỢ]",
    "o": "[óòỏõõọôốồổỗộơớờởỡợ]",
    "U": "[ÚÙỦŨỤƯỨỪỬỮỰ]",
    "u": "[úùủũụưứừửữự]",
    "Y": "[ÝỲỶỸỴ]",
    "y": "[ýỳỷỹỵ]",
    "D": "[Đ]",
    "d": "[đ]"
} -%}

REGEXP_REPLACE(
    REGEXP_REPLACE(
        REGEXP_REPLACE(
            REGEXP_REPLACE(
                REGEXP_REPLACE(
                    REGEXP_REPLACE(
                        REGEXP_REPLACE(
                            REGEXP_REPLACE(
                                REGEXP_REPLACE(
                                    REGEXP_REPLACE(
                                        REGEXP_REPLACE(
                                            REGEXP_REPLACE(
                                                REGEXP_REPLACE(
                                                    REGEXP_REPLACE(
                                                        {{ column_name }},
                                                        r'{{ replacements["A"] }}', 'A'
                                                    ),
                                                    r'{{ replacements["a"] }}', 'a'
                                                ),
                                                r'{{ replacements["E"] }}', 'E'
                                            ),
                                            r'{{ replacements["e"] }}', 'e'
                                        ),
                                        r'{{ replacements["I"] }}', 'I'
                                    ),
                                    r'{{ replacements["i"] }}', 'i'
                                ),
                                r'{{ replacements["O"] }}', 'O'
                            ),
                            r'{{ replacements["o"] }}', 'o'
                        ),
                        r'{{ replacements["U"] }}', 'U'
                    ),
                    r'{{ replacements["u"] }}', 'u'
                ),
                r'{{ replacements["Y"] }}', 'Y'
            ),
            r'{{ replacements["y"] }}', 'y'
        ),
        r'{{ replacements["D"] }}', 'D'
    ),
    r'{{ replacements["d"] }}', 'd'
)
{%- endmacro %}

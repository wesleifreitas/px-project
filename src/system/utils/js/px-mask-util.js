define(['../../services/module'], function(services) {
    'use strict';

    services.factory('pxMaskUtil', pxMaskUtil);

    pxMaskUtil.$inject = [];

    function pxMaskUtil() {

        var service = {};

        var tokens = {
            '0': {
                pattern: /\d/,
                _default: '0'
            },
            '9': {
                pattern: /\d/,
                optional: true
            },
            '#': {
                pattern: /\d/,
                optional: true,
                recursive: true
            },
            'S': {
                pattern: /[a-zA-Z]/
            },
            'U': {
                pattern: /[a-zA-Z]/,
                transform: function(c) {
                    return c.toLocaleUpperCase();
                }
            },
            'L': {
                pattern: /[a-zA-Z]/,
                transform: function(c) {
                    return c.toLocaleLowerCase();
                }
            },
            '$': {
                escape: true
            }
        };

        service.maskFormat = maskFormat;

        return service;

        function maskFormat(value, pattern, options) {

            pattern = pattern || '';
            options = options || {};
            options = {
                reverse: options.reverse || false,
                usedefaults: options.usedefaults || options.reverse
            };            

            return proccess(value, pattern, options);
        }

        function isEscaped(pattern, pos) {
            var count = 0;
            var i = pos - 1;
            var token = {
                escape: true
            };
            while (i >= 0 && token && token.escape) {
                token = tokens[pattern.charAt(i)];
                count += token && token.escape ? 1 : 0;
                i--;
            }
            return count > 0 && count % 2 === 1;
        }

        function calcOptionalNumbersToUse(pattern, value) {
            var numbersInP = pattern.replace(/[^0]/g, '').length;
            var numbersInV = value.replace(/[^\d]/g, '').length;
            return numbersInV - numbersInP;
        }

        function concatChar(text, character, options, token) {
            if (token && typeof token.transform === 'function') character = token.transform(character);
            if (options.reverse) return character + text;
            return text + character;
        }

        function hasMoreTokens(pattern, pos, inc) {
            var pc = pattern.charAt(pos);
            var token = tokens[pc];
            if (pc === '') return false;
            return token && !token.escape ? true : hasMoreTokens(pattern, pos + inc, inc);
        }

        function insertChar(text, char, position) {
            var t = text.split('');
            t.splice(position >= 0 ? position : 0, 0, char);
            return t.join('');
        }

        function proccess(value, pattern, options) {
            if (!value) {
                return {
                    result: '',
                    valid: false
                };
            }
            value = value + '';
            var pattern2 = pattern;
            var valid = true;
            var formatted = '';
            var valuePos = options.reverse ? value.length - 1 : 0;
            var optionalNumbersToUse = calcOptionalNumbersToUse(pattern2, value);
            var escapeNext = false;
            var recursive = [];
            var inRecursiveMode = false;

            var steps = {
                start: options.reverse ? pattern2.length - 1 : 0,
                end: options.reverse ? -1 : pattern2.length,
                inc: options.reverse ? -1 : 1
            };

            function continueCondition(options) {
                if (!inRecursiveMode && hasMoreTokens(pattern2, i, steps.inc)) {
                    return true;
                } else if (!inRecursiveMode) {
                    inRecursiveMode = recursive.length > 0;
                }

                if (inRecursiveMode) {
                    var pc = recursive.shift();
                    recursive.push(pc);
                    if (options.reverse && valuePos >= 0) {
                        i++;
                        pattern2 = insertChar(pattern2, pc, i);
                        return true;
                    } else if (!options.reverse && valuePos < value.length) {
                        pattern2 = insertChar(pattern2, pc, i);
                        return true;
                    }
                }
                return i < pattern2.length && i >= 0;
            }

            for (var i = steps.start; continueCondition(options); i = i + steps.inc) {
                var pc = pattern2.charAt(i);
                var vc = value.charAt(valuePos);
                var token = tokens[pc];
                if (!inRecursiveMode || vc) {
                    if (options.reverse && isEscaped(pattern2, i)) {
                        formatted = concatChar(formatted, pc, options, token);
                        i = i + steps.inc;
                        continue;
                    } else if (!options.reverse && escapeNext) {
                        formatted = concatChar(formatted, pc, options, token);
                        escapeNext = false;
                        continue;
                    } else if (!options.reverse && token && token.escape) {
                        escapeNext = true;
                        continue;
                    }
                }

                if (!inRecursiveMode && token && token.recursive) {
                    recursive.push(pc);
                } else if (inRecursiveMode && !vc) {
                    if (!token || !token.recursive) formatted = concatChar(formatted, pc, options, token);
                    continue;
                } else if (recursive.length > 0 && token && !token.recursive) {
                    // Recursive tokens most be the last tokens of the pattern
                    valid = false;
                    continue;
                } else if (!inRecursiveMode && recursive.length > 0 && !vc) {
                    continue;
                }

                if (!token) {
                    formatted = concatChar(formatted, pc, options, token);
                    if (!inRecursiveMode && recursive.length) {
                        recursive.push(pc);
                    }
                } else if (token.optional) {
                    if (token.pattern.test(vc) && optionalNumbersToUse) {
                        formatted = concatChar(formatted, vc, options, token);
                        valuePos = valuePos + steps.inc;
                        optionalNumbersToUse--;
                    } else if (recursive.length > 0 && vc) {
                        valid = false;
                        break;
                    }
                } else if (token.pattern.test(vc)) {
                    formatted = concatChar(formatted, vc, options, token);
                    valuePos = valuePos + steps.inc;
                } else if (!vc && token._default && options.usedefaults) {
                    formatted = concatChar(formatted, token._default, options, token);
                } else {
                    valid = false;
                    break;
                }
            }

            return {
                result: formatted,
                valid: valid
            };
        };
    }
});
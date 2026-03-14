/**
 * @file 表单验证工具函数
 * @description 提供表单字段验证逻辑：空值检测、同步规则验证、异步验证器、完整规则链执行
 * @author JunBin.Yang
 */

/**
 * 判断值是否为空
 * @param value 待检测值
 * @returns 是否为空
 */
export function isEmptyValue(value) {
  if (Array.isArray(value)) {
    return !value.length;
  }
  return value === "" || value === null || value === undefined;
}

/**
 * 执行同步验证规则
 * @param value 字段值
 * @param rule 验证规则
 * @returns 是否通过验证
 */
export function runSyncRule(value, rule) {
  if (isEmptyValue(value)) {
    return !rule.required;
  }
  if (typeof value === "string" && rule.pattern) {
    return rule.pattern.test(value);
  }
  if ((rule.min !== undefined || rule.max !== undefined) && (typeof value === "string" || Array.isArray(value))) {
    let minOk = true;
    let maxOk = true;
    if (rule.min !== undefined) {
      minOk = value.length >= rule.min;
    }
    if (rule.max !== undefined) {
      maxOk = value.length <= rule.max;
    }
    return minOk && maxOk;
  }
  return true;
}

/**
 * 执行异步验证器
 * @param value 字段值（字符串）
 * @param rule 包含 validator 的验证规则
 * @returns 验证结果 Promise（true 表示通过，字符串为错误消息）
 */
export function runRuleValidator(value, rule) {
  return new Promise(function (resolve) {
    var returnVal = rule.validator(value);
    if (typeof returnVal !== "boolean" && typeof returnVal !== "string") {
      returnVal.then(resolve);
      return;
    }
    resolve(returnVal);
  });
}

/**
 * 执行完整验证规则链
 * @param value 字段值
 * @param rules 验证规则数组
 * @param trigger 触发时机（可选，用于过滤规则）
 * @returns 第一个验证失败的错误消息，全部通过返回空字符串
 */
export function validateRules(value, rules, trigger) {
  return new Promise(function (resolve) {
    if (!rules || !rules.length) {
      resolve("");
      return;
    }
    var filteredRules = rules;
    if (trigger) {
      filteredRules = rules.filter(function (rule) {
        return !rule.trigger || rule.trigger === trigger;
      });
    }
    if (!filteredRules.length) {
      resolve("");
      return;
    }

    var index = 0;
    function next() {
      if (index >= filteredRules.length) {
        resolve("");
        return;
      }
      var rule = filteredRules[index];
      index++;

      // 同步规则校验
      if (!runSyncRule(value, rule)) {
        resolve(rule.message || "");
        return;
      }
      // 异步验证器
      if (rule.validator) {
        var strValue = value === undefined || value === null ? "" : String(value);
        runRuleValidator(strValue, rule).then(function (result) {
          if (result === true) {
            next();
          } else if (typeof result === "string") {
            resolve(result || rule.message || "");
          } else {
            resolve(rule.message || "");
          }
        });
      } else {
        next();
      }
    }
    next();
  });
}

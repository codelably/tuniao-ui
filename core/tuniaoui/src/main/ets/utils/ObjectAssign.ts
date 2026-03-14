/**
 * 对象合并
 * @author JunBin.Yang
 */

/**
 * 判断是否为纯粹的 Plain Object（而非类实例）
 * @param obj 待判断的对象
 * @returns 是否为 Plain Object
 */
function isPlainObject(obj: object): boolean {
  if (obj === null || typeof obj !== 'object') {
    return false;
  }
  const proto = Object.getPrototypeOf(obj);
  return proto === Object.prototype || proto === null;
}

/**
 * 深度合并多个对象（递归合并）
 * 注意：仅对 Plain Object 做递归深度合并。对于类实例（如 @ObservedV2 装饰的类），
 * 直接替换引用以确保 @Trace 的变更检测能正确触发。
 * @param target - 目标对象，合并结果将存入该对象
 * @param sources - 源对象数组，将按顺序合并到目标对象
 * @returns 合并后的目标对象
 */
export function ObjectAssign<T extends object, U extends Array<object | null | undefined>>(target: T, ...sources: U): T & Partial<NonNullable<U[number]>> {
  // 处理目标对象为null或undefined的情况
  if (target === null || target === undefined) {
    throw new TypeError('Cannot convert undefined or null to object');
  }

  // 没有源对象时直接返回目标对象
  if (!sources || sources.length === 0) {
    return target
  }

  // 深度合并辅助函数
  const deepAssign = (obj1: any, obj2: any): any => {
    // 处理obj2为null或undefined的情况
    if (obj2 === null || obj2 === undefined) {
      return obj1
    }

    // 遍历obj2的所有属性
    for (const key in obj2) {
      if (Object.prototype.hasOwnProperty.call(obj2, key)) {
        const obj1Val = obj1[key]
        const obj2Val = obj2[key]

        // 仅当两个值都是 Plain Object 时才递归合并；
        // 类实例（如 ResourceColorWrapper）直接替换，确保 @Trace 检测到引用变化
        if (
          obj1Val &&
            obj2Val &&
            typeof obj1Val === 'object' &&
            typeof obj2Val === 'object' &&
            !Array.isArray(obj1Val) &&
            !Array.isArray(obj2Val) &&
            isPlainObject(obj1Val) &&
            isPlainObject(obj2Val)
        ) {
          obj1[key] = deepAssign(obj1Val, obj2Val)
        } else {
          // 否则直接赋值（覆盖），包括类实例的替换
          obj1[key] = obj2Val
        }
      }
    }
    return obj1
  }

  // 逐个合并源对象
  sources.forEach(source => {
    if (source !== null && source !== undefined) {
      target = deepAssign(target, source) as T & U[number]
    }
  })

  return target
}
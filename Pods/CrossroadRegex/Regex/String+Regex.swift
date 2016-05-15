//===--- String+Regex.swift -----------------------------------------------===//
//Copyright (c) 2016 Daniel Leping (dileping)
//
//Licensed under the Apache License, Version 2.0 (the "License");
//you may not use this file except in compliance with the License.
//You may obtain a copy of the License at
//
//http://www.apache.org/licenses/LICENSE-2.0
//
//Unless required by applicable law or agreed to in writing, software
//distributed under the License is distributed on an "AS IS" BASIS,
//WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
//See the License for the specific language governing permissions and
//limitations under the License.
//===----------------------------------------------------------------------===//

public extension String {
    public var r : Regex? {
        get {
            return try? Regex(pattern: self)
        }
    }
    
    public func split(regex:RegexType?) -> [String] {
        guard let regex = regex else {
            return [self]
        }
        return regex.split(self)
    }
}

infix operator =~ {associativity left precedence 140}
infix operator !~ {associativity left precedence 140}

public func =~(source:String, regex:RegexType?) -> Bool {
    guard let matches = regex?.matches(source) else {
        return false
    }
    return matches
}

public func =~(source:String, pattern:String) -> Bool {
    return source =~ pattern.r
}

public func !~(source:String, regex:RegexType?) -> Bool {
    return !(source =~ regex)
}

public func !~(source:String, pattern:String) -> Bool {
    return !(source =~ pattern.r)
}
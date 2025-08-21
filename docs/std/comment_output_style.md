# Comment & Output Style

---

## Comment

```cpp
// [<username> Begin][20220829]: sth

// [<username> End]
```

## Log

```cpp
// [CGGOS] <Function> <Line>: sth

std::cout << "[<username>] " << __FUNCTION__ << " " << __LINE__ << ": "
          << "sth" << std::endl;

logger_ptr_->set_pattern("[%Y-%m-%d %H:%M:%S.%e %z] [%t@%P] [%n] [%^%l%$] [%! %#] %v");
```

extern void greet(const char * who);

typedef union
{
    unsigned int value;
    struct
    {
         unsigned int seconds   :6;
         unsigned int minutes  :6;
         unsigned int hours   :5;
         unsigned int days    :15;
    } info;
} t32_date_time;

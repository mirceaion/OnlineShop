using System;
using System.Collections.Generic;
using System.Text;

namespace Entities
{
    public class Purchase
    {
        public int Id { get; set; }
        public int UserId { get; set; }
        public int ProductId { get; set; }
    }
}

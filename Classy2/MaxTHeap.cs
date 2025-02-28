using System;
using System.Collections;
using System.Collections.Generic;

namespace Zeva
{
	public class MaxTHeap<T> : List<T> where T : class, IComparable<T>, IEquatable<T>
	{
		private Dictionary<T, int> _stats = new Dictionary<T, int>();


		public T Pop()
		{
			var result = base[0];
			if (_stats.ContainsKey((T)result) && _stats[(T)result] > 1)
			{
				_stats[(T)result]--;
			}
			else
			{
				base[0] = base[Count - 1];
				base.RemoveAt(Count - 1);
				BubbleDown(0);
				_stats.Remove((T)result);
			}
			return (T)result;
		}

		public T Peek()
		{
			return (T)base[0];
		}


		private void BubbleDown(int index)
		{
			if (Count == 0)
				return;
			if (2 * index + 1 > Count - 1)
				return;

			if (2 * index + 2 > Count - 1)
			{
				SwapIfSmaller(index, 2 * index + 1);
				return;
			}

			var minIndex = ((T)base[2 * index + 1]).CompareTo(((T)base[2 * index + 2]))>0 ? 2 * index + 1 : 2 * index + 2;
			SwapIfSmaller(index, minIndex);
		}

		public void SwapIfSmaller(int index1, int index2)
		{
			if (((T)base[index1]).CompareTo(((T)base[index2])) < 0)
			{
				var temp = base[index1];
				base[index1] = base[index2];
				base[index2] = temp;
				BubbleDown(index2);
			}
		}

		public void Push(T toPush)
		{
			if (_stats.ContainsKey((T)toPush))
			{
				_stats[toPush]++;
			}
			else
			{
				base.Insert(Count, toPush);
				BubbleUp(Count - 1);
				_stats.Add(toPush, 1);
			}
		}

		private void BubbleUp(int index)
		{
			if (index == 0)
				return;

			var parent = (index - 1) / 2;
			if (((T)base[parent]).CompareTo(((T)base[index])) < 0)
			{
				var temp = base[index];
				base[index] = base[parent];
				base[parent] = temp;
				BubbleUp(parent);
			}
			BubbleDown(index);
		}

	}
}
